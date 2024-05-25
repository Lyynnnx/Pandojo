package com.sultan.Vitek;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.io.DataInput;
import java.io.File;
import java.io.IOException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

public class ReadJson {
    private final ObjectMapper objectMapper = new ObjectMapper();
    public ReadJson(){

    }
    public Map<String, String> readJsonFromFile(String filePath) throws IOException {
        File file = new File(filePath);
        if (!file.exists()) {
            return new HashMap<>();
        }
        JsonNode jsonNode = objectMapper.readTree(file);
        return readJson(jsonNode);
    }

    public Map<String, String> readJson(JsonNode jsonNode) {
        Map<String, String> resultMap = new HashMap<>();
        Iterator<Map.Entry<String, JsonNode>> fields = jsonNode.fields();
        while (fields.hasNext()) {
            Map.Entry<String, JsonNode> field = fields.next();
            resultMap.put(field.getKey(), field.getValue().asText());
        }
        return resultMap;
    }

}
