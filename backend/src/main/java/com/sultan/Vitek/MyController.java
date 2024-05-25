package com.sultan.Vitek;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.RequestEntity;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import com.sultan.Vitek.ReadJson;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@RestController
//@RequestMapping("/api")
public class MyController {
    /*private List<Message> messages = new ArrayList<>();
    private Message chlen = new Message("xuy");
    private ReadJson json = new ReadJson();
    private static final String FILE_PATH = "C:\\Users\\Win11 Pro\\Desktop\\messages.json";
    private final ObjectMapper objectMapper = new ObjectMapper();
    @GetMapping("/messagesFor")
       public Message getMessages() {
        System.out.println("mama");
        /*Map<String,Object> getZalupa = json.sendInfo();
        Message chlen = new Message(getZalupa.get("content").toString());

        return chlen;
    }

    @PostMapping("/messages")
    public ResponseEntity<String> postMessage(@RequestBody JsonNode jsonNode) {
        /*try {
            // Save the JSON content to the file
            Files.write(Paths.get(FILE_PATH), jsonNode.toString().getBytes(), StandardOpenOption.TRUNCATE_EXISTING, StandardOpenOption.CREATE);

            // Read the content key value
            String contentValue = jsonNode.get("content").asText();

            // Respond with the value of the content key
            return ResponseEntity.ok("Content received: " + contentValue);
        } catch (IOException e) {
            return ResponseEntity.status(500).body("File upload failed: " + e.getMessage());
        }


    }
}
*/
    private static final String USER_DATA_FILE = "C:\\Users\\Win11 Pro\\Desktop\\user-data.json";
    private ObjectMapper objectMapper = new ObjectMapper();

    List<User> users = new ArrayList<>();
    ReadJson readJson =new ReadJson();

    public MyController() throws IOException {
    }

    public void fillUser(Map<String,Object> get) throws IOException {
        for(int i =0; i< get.size();i++){
            if(!get.isEmpty())
            users.add(new User(get.get("email"),get.get("password")));
        }
    }

    @GetMapping("/users")
    public Map<String, String> getUsers() throws IOException {
        return readJson.readJsonFromFile(USER_DATA_FILE);
    }

    @PostMapping("/register")
    public ResponseEntity<String> registerUser(@RequestBody Map<String, String> registerRequest) throws IOException {
        String email = registerRequest.keySet().toString();
        String password = registerRequest.values().toString();

        if (email == null || password == null) {
            return ResponseEntity.status(228).body("Missing field");
        }

        Map<String, String> users = getUsers();

        if (users.containsKey(email)) {
            return ResponseEntity.status(420).body("This Email is taken");
        }

        users.put(email, password);

        // Save the updated user list to the file
        objectMapper.writeValue(new File(USER_DATA_FILE), users);

        return ResponseEntity.ok("User successfully registered");
    }

    @PostMapping("/login")
    public ResponseEntity<String> loginUser(@RequestBody Map<String, String> loginRequest) throws IOException {
        String email = loginRequest.keySet().toString();
        String password = loginRequest.values().toString();
        if (email == null || password == null) {
            return ResponseEntity.status(228).body("Missing field");
        }
        Map<String, String> users = getUsers();

        if (!users.containsKey(email)) {
            return ResponseEntity.status(420).body("This Email doesn't exist!");
        }
        if(!(users.get(email).equals(password))){
            return ResponseEntity.status(600).body("Password doesn't match");
        }
        return ResponseEntity.ok("User successfully logged in!");

    }

}