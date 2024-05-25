package com.sultan.Vitek;

import com.fasterxml.jackson.databind.JsonNode;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.method.annotation.MvcUriComponentsBuilder;

import java.io.IOException;
import java.net.MalformedURLException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.nio.file.StandardOpenOption;
import java.util.Map;
import java.util.UUID;

import static ch.qos.logback.classic.spi.ThrowableProxyVO.build;

@Controller
@RequestMapping
public class VideoUploadController {

    private static final Logger logger = LoggerFactory.getLogger(VideoController.class);

    private final Path rootLocation = Paths.get("C:\\Users\\Win11 Pro\\Desktop\\video-storage");
    public String forEgor = "";
    public boolean decision;

    public VideoUploadController() {
        try {
            Files.createDirectories(rootLocation);
            logger.info("Video storage directory created at: " + rootLocation.toAbsolutePath().toString());
        } catch (IOException e) {
            logger.error("Could not initialize storage location", e);
            throw new RuntimeException("Could not initialize storage location", e);
        }
    }


    @PostMapping("/upload")
    public ResponseEntity<String> handleVideoUpload(@RequestParam("file") MultipartFile file) {
        try {
            logger.info("Received file: " + file.getOriginalFilename());

            // Save the file with a unique name to avoid conflicts
            String uniqueFileName = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();
            Path destinationFile = this.rootLocation.resolve(uniqueFileName).normalize().toAbsolutePath();
            file.transferTo(destinationFile);
            logger.info("File saved to: " + destinationFile.toString());

            // Return the URL to access the uploaded video
            String videoUrl = MvcUriComponentsBuilder
                    .fromMethodCall(MvcUriComponentsBuilder.on(VideoController.class).getVideo(uniqueFileName))
                    .build()
                    .toUri()
                    .toString();
            logger.info("Video URL: " + videoUrl);
            forEgor = videoUrl;

            return ResponseEntity.ok(videoUrl);


        } catch (IOException e) {
            logger.error("Failed to store video", e);
            return ResponseEntity.internalServerError().body("Failed to store video");
        }
    }
    @GetMapping("/Egorka")
    public ResponseEntity<String> sendToPy(){
        return ResponseEntity.ok(forEgor);
    }
    @GetMapping("/finalAnswer")
    public ResponseEntity<Boolean> sendAIAnswer(){
        return ResponseEntity.ok(decision);
    }
    @PostMapping("/answerAIJson")
    public ResponseEntity<String> getJSONBoolean(@RequestBody JsonNode jsonNode){

        decision = jsonNode.get("boolean").asBoolean();

        return ResponseEntity.ok("Content received: " + decision);

    }



   /* @GetMapping("/uploaded/{filename:.+}")
    public ResponseEntity<Resource> serveVideo(@PathVariable String filename) {
        try {
            logger.info("Serving video: " + filename);
            Path file = rootLocation.resolve(filename).normalize().toAbsolutePath();
            Resource resource = new UrlResource(file.toUri());

            if (resource.exists() && resource.isReadable()) {
                return ResponseEntity.ok()
                        .contentType(MediaType.parseMediaType("video/mp4"))
                        .header(HttpHeaders.CONTENT_DISPOSITION, "inline; filename=\"" + resource.getFilename() + "\"")
                        .body(resource);
            } else {
                logger.warn("Video not found or not readable: " + filename);
                return ResponseEntity.notFound().build();
            }
        } catch (MalformedURLException e) {
            logger.error("Error while serving video", e);
            return ResponseEntity.internalServerError().build();
        }
    }*/
}
