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
import models.User;

/**
 * Servlet implementation class GetUserInfo
 */
@WebServlet("/GetUserInfo")
public class GetUserInfo extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetUserInfo() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	
		HttpSession session = request.getSession(false);
		String cview = "";
		ManageUser userManager = new ManageUser();
		
		if ( session != null) {
			int uid = (int)session.getAttribute("uid");
			cview = "/viewUserInfo.jsp";
			User user = (User)session.getAttribute("user");
			User viewuser = (User)session.getAttribute("viewuser");
			if(user.getUid() == viewuser.getUid()) {
				User newuser = new User();
				
				try {
					BeanUtils.populate(newuser, request.getParameterMap());
					newuser = userManager.getUser(uid);
					userManager.finalize();
				} catch (Exception e) {
					e.printStackTrace();
				}
				
				request.setAttribute("user",newuser);
			}else {
			//Un usuari ha deixat de ser seguit.
				User newuser = new User();
				
				try {
					BeanUtils.populate(newuser, request.getParameterMap());
					newuser = userManager.getUser(viewuser.getUid());
					session.setAttribute("isFollowed", userManager.userIsFollowed(uid, viewuser.getUid()));
					userManager.finalize();
				} catch (Exception e) {
					e.printStackTrace();
				}
				System.out.println(viewuser.getUid());
				session.setAttribute("viewuser",newuser);
				
			}
		}
		else {
			try {
				request.setAttribute("viewuser", userManager.getUser(Integer.parseInt(request.getParameter("uid"))));
				userManager.finalize();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			cview = "/viewUserInfoAnonymouse.jsp";
		}
		
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(cview); 
		dispatcher.include(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}