package com.standalone.demo;


import org.apache.log4j.Logger;
import org.apache.log4j.PropertyConfigurator;

import java.io.*;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.concurrent.Executors;
import java.util.concurrent.ScheduledExecutorService;
import java.util.concurrent.TimeUnit;

/**
 * Hello world!
 *
 */
public class App
{
    private static final Logger LOGGER = Logger.getLogger(App.class);

    private static final ScheduledExecutorService taskScheduler = Executors
            .newScheduledThreadPool(1);

    public static void main( String[] args ) {
        String root = App.class.getClassLoader().getResource(".").getPath();
        Path path = Paths.get("conf", "log4j.properties");

        PropertyConfigurator.configure(root+path.toString());

        System.out.println( "Hello World!" );


        taskScheduler.scheduleAtFixedRate(new Task(), 0, 5, TimeUnit.MINUTES);
    }

    static class Task implements Runnable {
        public void run() {
            LOGGER.info("task running...");
            String root = App.class.getClassLoader().getResource(".").getPath();
            String format = "YYMMdd_HHmmss";
            SimpleDateFormat sdf = new SimpleDateFormat(format);

            File file = new File(root + sdf.format(new Date()) +"-record.txt");

            LOGGER.info("file: " + file.getPath());
            try {
                FileWriter os = new FileWriter(file);
                BufferedWriter wr = new BufferedWriter(os);
                wr.write("load properties file at: " + root);
                wr.flush();
                wr.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
}
