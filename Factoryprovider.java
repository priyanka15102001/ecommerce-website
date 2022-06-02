
package com.learn.mycart.helper;

import org.hibernate.SessionFactory;
import org.hibernate.cfg.Configuration;


public class Factoryprovider {
    private static SessionFactory factory;
    
    public static SessionFactory getFacory()
    {
        try {
            if(factory == null){
           factory = new Configuration().configure("hibernate.cfg.xml").buildSessionFactory();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return factory;
    }
    
}
