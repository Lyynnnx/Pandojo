import cv2
import time
import pose_det_model as pm
import pandas as pd
from matplotlib.patches import ConnectionPatch
import matplotlib.pyplot as plt
import numpy as np
import scipy.spatial.distance as dist
import requests
from bs4 import BeautifulSoup
from dtw import dtw
import os
import time
import re

while True:
    page_url = "https://764f-95-130-161-159.ngrok-free.app/Egorka" #get url
    post_url = 'https://764f-95-130-161-159.ngrok-free.app/answerAIJson' #post url
    response = requests.get(page_url)
    # print(response.content)


    # Используем регулярное выражение для поиска URL
    url_pattern = re.compile(r'http://\S+\.temp')
    found_urls = url_pattern.findall(f"{response.content}")

    with open("url.txt") as file:
        str = file.read()
    i = 0
    while(str == found_urls[0]):
        i+=1
        print(i)
        time.sleep(3)
        response = requests.get(page_url)
        url_pattern = re.compile(r'http://\S+\.temp')
        found_urls = url_pattern.findall(f"{response.content}")

    with open("url.txt", "w") as file:
        file.write(found_urls[0])

    cap = cv2.VideoCapture(found_urls[0]) # name of the video file, that we use
    # cap = cv2.VideoCapture("0524_1.mp4") # name of the video file, that we use

    # flag = True
    pTime = 0
    detector = pm.poseDetector()
    x_24_list = []
    y_24_list = []
    x_26_list = []
    y_26_list = []
    x_28_list = []
    y_28_list = []

    while True:
        try:
            success, img = cap.read()
            img = detector.findPose(img)
            lmList = detector.findPosition(img, draw=False)
            if len(lmList) !=0:
                # counting vectors of the legs,
                # TODO: adaptive name of each list
                x_24_list.append(lmList[24][1])
                y_24_list.append(lmList[24][2])
                x_26_list.append(lmList[26][1])
                y_26_list.append(lmList[26][2])
                x_28_list.append(lmList[28][1])
                y_28_list.append(lmList[28][2])

                # print(f"{lmList[26][1]} - {lmList[24][1]} = {lmList[26][1] - lmList[24][1]}, {lmList[26][2]} - {lmList[24][2]} = {lmList[26][2] - lmList[24][2]}")
                cv2.circle(img, (lmList[24][1], lmList[24][2]), 15, (0, 0, 255), cv2.FILLED)
                cv2.circle(img, (lmList[26][1], lmList[26][2]), 15, (0, 0, 255), cv2.FILLED)
                cv2.circle(img, (lmList[28][1], lmList[28][2]), 15, (0, 0, 255), cv2.FILLED)

            cTime = time.time()
            fps = 1 / (cTime - pTime)
            pTime = cTime

            cv2.putText(img, str(int(fps)), (70, 50), cv2.FONT_HERSHEY_PLAIN, 3,
                        (255, 0, 0), 3)

            cv2.imshow("Image", img)
            cv2.waitKey(1)
        except:
            print("THE END OF COLLECTING")
            break

    # create dataframe
    data = {"x_24_t": x_24_list,
            "y_24_t": y_24_list,
            "x_26_t": x_26_list,
            "y_26_t": y_26_list,
            "x_28_t": x_28_list,
            "y_28_t": y_28_list}
    df = pd.DataFrame(data)
    # print(df.head())
    # print(df.tail())
    df.to_csv("test_side_kick_df_2.csv")

    df_perf = pd.read_csv("perf_side_kick.csv")
    df_test = pd.read_csv("test_side_kick_df_2.csv")
    def dp(dist_mat):
        """
        Find minimum-cost path through matrix `dist_mat` using dynamic programming.

        The cost of a path is defined as the sum of the matrix entries on that
        path. See the following for details of the algorithm:

        - http://en.wikipedia.org/wiki/Dynamic_time_warping
        - https://www.ee.columbia.edu/~dpwe/resources/matlab/dtw/dp.m

        The notation in the first reference was followed, while Dan Ellis's code
        (second reference) was used to check for correctness. Returns a list of
        path indices and the cost matrix.
        """

        N, M = dist_mat.shape

        # Initialize the cost matrix
        cost_mat = np.zeros((N + 1, M + 1))
        for i in range(1, N + 1):
            cost_mat[i, 0] = np.inf
        for i in range(1, M + 1):
            cost_mat[0, i] = np.inf

        # Fill the cost matrix while keeping traceback information
        traceback_mat = np.zeros((N, M))
        for i in range(N):
            for j in range(M):
                penalty = [
                    cost_mat[i, j],      # match (0)
                    cost_mat[i, j + 1],  # insertion (1)
                    cost_mat[i + 1, j]]  # deletion (2)
                i_penalty = np.argmin(penalty)
                cost_mat[i + 1, j + 1] = dist_mat[i, j] + penalty[i_penalty]
                traceback_mat[i, j] = i_penalty

        # Traceback from bottom right
        i = N - 1
        j = M - 1
        path = [(i, j)]
        while i > 0 or j > 0:
            tb_type = traceback_mat[i, j]
            if tb_type == 0:
                # Match
                i = i - 1
                j = j - 1
            elif tb_type == 1:
                # Insertion
                i = i - 1
            elif tb_type == 2:
                # Deletion
                j = j - 1
            path.append((i, j))

        # Strip infinity edges from cost_mat before returning
        cost_mat = cost_mat[1:, 1:]
        return (path[::-1], cost_mat)
    #%%

    #%%

    x_24_p = df_perf["x_24"]
    x_24_t = df_test["x_24_t"]
    N = x_24_p.shape[0]
    M = x_24_t.shape[0]
    dist_mat = np.zeros((N, M))
    for i in range(N):
        for j in range(M):
            dist_mat[i, j] = abs(x_24_p[i] - x_24_t[j])

    limit = 330
    #%%
    _24_p = df_perf[['x_24', 'y_24']].to_numpy()
    _24_t = df_test[['x_24_t', 'y_24_t']].to_numpy()
    dist_mat = dist.cdist(_24_p, _24_t, "euclidean")
    path, cost_mat = dp(dist_mat)
    flag_hip = True
    if ((cost_mat[-1, -1]/(M + N)) > limit):
        flag_hip = False
        # flag = False
    print("Normalized alignment cost: {:.4f}".format(cost_mat[-1, -1]/(M + N)) + f"{flag_hip}")

    #Normalized alignment cost: 108.4669
    #%%
    _26_p = df_perf[['x_26', 'y_26']].to_numpy()
    _26_t = df_test[['x_26_t', 'y_26_t']].to_numpy()
    dist_mat = dist.cdist(_26_p, _26_t, "euclidean")
    path, cost_mat = dp(dist_mat)
    flag_knee = True
    if ((cost_mat[-1, -1]/(M + N)) > limit):
        flag_knee = False;
    print("Normalized alignment cost: {:.4f}".format(cost_mat[-1, -1]/(M + N)) + f"{flag_knee}")

    # Normalized alignment cost: 92.5429
    #%%
    _28_p = df_perf[['x_28', 'y_28']].to_numpy()
    _28_t = df_test[['x_28_t', 'y_28_t']].to_numpy()
    dist_mat = dist.cdist(_28_p, _28_t, "euclidean")
    path, cost_mat = dp(dist_mat)
    flag_foot = True
    if ((cost_mat[-1, -1]/(M + N)) > limit):
        flag_foot = False
    print("Normalized alignment cost: {:.4f}".format(cost_mat[-1, -1]/(M + N)) + f"{flag_foot}")

    # print(flag)
    os.remove("test_side_kick_df_2.csv")
    #%%


    # Data to be sent in the request
    data = {
        'hip': flag_hip,
        'knee': flag_knee,
        'foot': flag_foot

    }

    # Sending POST request with JSON body
    response = requests.post(post_url, json=data)

    # Response processing
    #%%
