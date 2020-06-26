package controllers;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;
import java.util.Collections;
import java.util.List;

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
import models.dTmodel;

/**
 * Servlet implementation class GetFollowers
 */
@WebServlet("/GetFollowers")
public class GetFollowers extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetFollowers() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		List<User> users = Collections.emptyList();
		dTmodel dt = new dTmodel();
		int viewuid = Integer.parseInt(request.getParameter("uid"));
		HttpSession session = request.getSession(false);
		
		if(session != null) {
			ManageUser userManager = new ManageUser();
			try {
				BeanUtils.populate(dt, request.getParameterMap());
				users = userManager.getUserFollowers(viewuid,dt.getStart(),dt.getEnd());
			} catch (IllegalAccessException | InvocationTargetException e) {
				e.printStackTrace();
			}
			
			for(int i = 0; i < users.size(); i++) {
				users.get(i).setIsFollowed(userManager.userIsFollowed((int)session.getAttribute("uid"), users.get(i).getUid()));
			}
			
			userManager.finalize();
			request.setAttribute("users",users);
			RequestDispatcher dispatcher = request.getRequestDispatcher("/viewFollowers.jsp"); 
			dispatcher.forward(request,response);
		}else {
			ManageUser userManager = new ManageUser();
			try {
				BeanUtils.populate(dt, request.getParameterMap());
				users = userManager.getUserFollowers(viewuid,dt.getStart(),dt.getEnd());
			} catch (IllegalAccessException | InvocationTargetException e) {
				e.printStackTrace();
			}
			
			userManager.finalize();
			request.setAttribute("users",users);
			RequestDispatcher dispatcher = request.getRequestDispatcher("/viewFollowersFromAnonymouse.jsp"); 
			dispatcher.forward(request,response);
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
