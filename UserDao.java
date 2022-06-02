
package com.learn.mycart.dao;

import com.learn.mycart.entites.user;
import org.hibernate.SessionFactory;
import org.hibernate.Session;
import org.hibernate.query.Query;



public class UserDao {
    private SessionFactory factory;

    public UserDao(SessionFactory factory) {
        this.factory = factory;
    }
    
    
    //get user by email and password
    public user getUserByEmailAndPassword(String email,String password)
    {
           user  user=null;
        
        try {
            String query="from user where userEmail=:e and userPassword=:p";
            Session session = this.factory.openSession();
            Query q = session.createQuery(query);
            q.setParameter("e",email);
            q.setParameter("p",password);
            user=(user) q.uniqueResult();
            
            session.close();
            
        } catch (Exception e) {
            e.printStackTrace();
        }
        return user;
    }    
}
