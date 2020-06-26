package controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import managers.ManageUser;
import models.User;
import utils.PwdHashGenerator;

/**
 * Servlet implementation class ChangePwd
 */
@WebServlet("/ChangePwd")
public class ChangePwd extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public ChangePwd() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		//response.getWriter().append("Served at: ").append(request.getContextPath());
		
		String currentPwd = request.getParameter("currentPwd");
		
		String newPwd = request.getParameter("newPwd");
		
		Integer uid = Integer.parseInt(request.getParameter("uid"));
		
		ManageUser userManager = new ManageUser();
		
		User user = null;
		
		try {
			 user = userManager.getUser(uid);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		if(currentPwd == newPwd) {
			response.getWriter().append("Please, choose different password");
		}else {
			/* Generar salt i password+salt hashejats */
			String base64salt = user.getSalt(); // Salt de 16 bytes.
			String base64pwd = user.getHashedPassword(); 
			Boolean currentPwdOK = PwdHashGenerator.checkPassword(currentPwd, base64pwd, base64salt);
			
			if(currentPwdOK) {
				userManager.editUserPassword(uid, newPwd);
				response.getWriter().append("Password changed successfully");
			}else {
				response.getWriter().append("Current password is wrong");
			}
			
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
