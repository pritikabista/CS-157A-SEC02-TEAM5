package com.medicalims.util;

import org.mindrot.jbcrypt.BCrypt;

public class HashPw {
    
    //hash pwd
    public static String hashedPwd(String plainPwd){ 
        String hashedPwd = BCrypt.hashpw(plainPwd, BCrypt.gensalt()); 
        return hashedPwd;
    }

    //verify pwd
    public static boolean checkPwd(String plainPwd, String hashedPwdFromDatabase){
        boolean match = BCrypt.checkpw(plainPwd, hashedPwdFromDatabase);
        return match;
    }

}
