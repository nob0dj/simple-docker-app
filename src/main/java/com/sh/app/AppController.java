package com.sh.app;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class AppController {
    @Value("${app.version:1.0.0}")
    String version;

    @GetMapping("/")
    public String index(){
        return "Hello~ Simple Docker App + Github Action 🎃 : " + version;
    }
}
