package controllers;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.beanutils.BeanUtils;

import managers.ManageUser;
import models.Login;
import models.User;

/**
 * Servlet implementation class LoginController
 */
@WebServlet("/LoginController")
public class LoginController extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public LoginController() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		System.out.print("LoginController: ");
		
		Login login = new Login();
		ManageUser manager = new ManageUser();
	    try {
			
	    	BeanUtils.populate(login, request.getParameterMap());
	    	
	    	User user = manager.getUser(manager.getUserID(login.getMail()));
	    	
	    	Integer loginResult = null;
	
	    	if ( login.isComplete() && (loginResult = manager.checkLogin(login.getMail(), login.getPwd())) == 0 ) {
		    	
	    		System.out.println("login OK, forwarding to ViewLoginDone ");
		    	HttpSession session = request.getSession();
		    	session.setAttribute("uid", user.getUid());
		    	session.setAttribute("viewuser", user);
		    	session.setAttribute("user", user);
		    	session.setAttribute("defaultDtweets", "GetTweetsFromUser");
		    	manager.finalize();
		    	RequestDispatcher dispatcher = request.getRequestDispatcher("ViewLoginDone.jsp");
			    dispatcher.forward(request, response);
			    
		    } 
			else {
				System.out.println("login FAIL, forwarding to ViewLoginForm ");
				login.restartFields();
				if(loginResult != null) {
					request.setAttribute("db_error", (int)loginResult);
				}
				manager.finalize();
				request.setAttribute("login",login);
			    RequestDispatcher dispatcher = request.getRequestDispatcher("ViewLoginForm.jsp");
			    dispatcher.forward(request, response);
		    	
		    }
		} catch (Throwable e) {
			e.printStackTrace();
		}
	    
	}
		
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}

