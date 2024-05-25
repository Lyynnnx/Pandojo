package com.sultan.Vitek;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.net.MalformedURLException;
import java.nio.file.Path;
import java.nio.file.Paths;

@RestController
//@RequestMapping("/videos")
public class VideoController {

   /* @GetMapping("/videos")
    public ResponseEntity<Resource> getVideo() {
        try {
            // Path to the video file
            Path videoPath = Paths.get("C:\\Users\\Win11 Pro\\Downloads\\banana.mp4");
            Resource resource = new UrlResource(videoPath.toUri());

            // Check if the resource exists and is readable
            if (!resource.exists() || !resource.isReadable()) {
                throw new RuntimeException("Video not found or not readable");
            }

            return ResponseEntity.ok()
                    .contentType(MediaType.parseMediaType("video/mp4"))
                    .header(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=\"" + resource.getFilename() + "\"")
                    .body(resource);

        } catch (MalformedURLException e) {
            throw new RuntimeException("Error while reading the video file", e);
        }
    }*/
   @GetMapping("/{filename:.+}")
   public ResponseEntity<Resource> getVideo(@PathVariable String filename) {
       try {
           // Path to the video file
           Path videoPath = Paths.get("C:\\Users\\Win11 Pro\\Desktop\\video-storage").resolve(filename).normalize();
           Resource resource = new UrlResource(videoPath.toUri());

           // Check if the resource exists and is readable
           if (!resource.exists() || !resource.isReadable()) {
              // throw new RuntimeException("Video not found or not readable");
           }

           return ResponseEntity.ok()
                   .contentType(MediaType.parseMediaType("video/mp4"))
                   .header(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=\"" + resource.getFilename() + "\"")
                   .body(resource);

       } catch (MalformedURLException e) {
           throw new RuntimeException("Error while reading the video file", e);
       }
   }
    @GetMapping("/taekwando")
    public ResponseEntity<Resource> getVideoTaekwando() {
        try {
            Path videoPath = Paths.get("C:\\Users\\Win11 Pro\\Desktop\\side_kick_video_white.mp4").normalize();
            Resource resource = new UrlResource(videoPath.toUri());

            return ResponseEntity.ok()
                    .contentType(MediaType.parseMediaType("video/mp4"))
                    .header(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=\"" + resource.getFilename() + "\"")
                    .body(resource);

        } catch (MalformedURLException e) {
            throw new RuntimeException("Error while reading the video file", e);
        }
    }
}