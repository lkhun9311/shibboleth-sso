package my.auth;

import javax.security.auth.Subject;
import javax.security.auth.callback.*;
import javax.security.auth.login.LoginException;
import javax.security.auth.spi.LoginModule;
import java.sql.*;
import java.util.Map;
import org.mindrot.jbcrypt.BCrypt;

public class JdbcLoginModule implements LoginModule {

    private Subject subject;
    private CallbackHandler callbackHandler;
    private Map<String, ?> options;

    private String dbUrl;
    private String dbUser;
    private String dbPassword;
    private String userQuery;

    private String username;
    private String password;

    @Override
    public void initialize(Subject subject, CallbackHandler callbackHandler,
                           Map<String, ?> sharedState, Map<String, ?> options) {
        this.subject = subject;
        this.callbackHandler = callbackHandler;
        this.options = options;

        dbUrl = (String) options.get("dbUrl");
        dbUser = (String) options.get("dbUser");
        dbPassword = (String) options.get("dbPassword");
        userQuery = (String) options.get("userQuery");
    }

    @Override
    public boolean login() throws LoginException {
        try {
            NameCallback nameCallback = new NameCallback("Username: ");
            PasswordCallback passwordCallback = new PasswordCallback("Password: ", false);
            callbackHandler.handle(new Callback[]{nameCallback, passwordCallback});

            username = nameCallback.getName();
            password = new String(passwordCallback.getPassword());

            try (Connection conn = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
                 PreparedStatement stmt = conn.prepareStatement(userQuery)) {

                stmt.setString(1, username);
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        String dbPassword = rs.getString(1).trim();
//                        return password.equals(dbPassword);
//                        System.out.println("input password: [" + password + "]");
//                        System.out.println("database password: [" + dbPassword + "]");
//                        System.out.println("check result: " + BCrypt.checkpw(password, dbPassword));

//                        String testpassword = "admin";
//                        String testhashed = BCrypt.hashpw(testpassword, BCrypt.gensalt(12));
//                        System.out.println("BCrypt hash for 'admin': [" + testhashed +"]");

                        if (BCrypt.checkpw(password, dbPassword)) {
                            return true;
                        }
                    }
                }
            }
        } catch (Exception e) {
            throw new LoginException("Login failed: " + e.getMessage());
        }

        throw new LoginException("Invalid credentials.");
    }

    @Override
    public boolean commit() { return true; }

    @Override
    public boolean abort() { return false; }

    @Override
    public boolean logout() { return true; }
}