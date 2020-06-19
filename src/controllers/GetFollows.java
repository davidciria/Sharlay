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
 * Servlet implementation class GetFollows
 */
@WebServlet("/GetFollows")
public class GetFollows extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetFollows() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		System.out.println("Hola mundo");
		List<User> users = Collections.emptyList();
		dTmodel dt = new dTmodel();
		
		HttpSession session = request.getSession(false);
		int uid = (int)session.getAttribute("uid");
		
		try {
			BeanUtils.populate(dt, request.getParameterMap());
			ManageUser userManager = new ManageUser();
			users = userManager.getUserFollows(uid,dt.getStart(),dt.getEnd());
			userManager.finalize();
		
		} catch (IllegalAccessException | InvocationTargetException e) {
			e.printStackTrace();
		}

		request.setAttribute("users",users);
		RequestDispatcher dispatcher = request.getRequestDispatcher("/viewFollows.jsp"); 
		dispatcher.forward(request,response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}