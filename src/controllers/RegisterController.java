package controllers;

import java.io.IOException;
import java.lang.reflect.InvocationTargetException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.commons.beanutils.BeanUtils;

import managers.ManageUser;
import models.User;

/**
 * Servlet implementation class FormController
 */
@WebServlet("/RegisterController")
public class RegisterController extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public RegisterController() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		
		User model = new User();
		String view = "ViewRegisterForm.jsp";
		
		
		try {
			BeanUtils.populate(model, request.getParameterMap());
			ManageUser manager = new ManageUser();
			if (manager.isComplete(model)) {
				boolean userAdded = manager.addUser(model, model.getPwd1());
				manager.finalize();
				if (userAdded) {
					view = "ViewLoginForm.jsp";
					request.setAttribute("registered", true);
					request.setAttribute("username", model.getUsername());
					request.setAttribute("mail", model.getMail());
				} else {
					model.setError(1, true);
					model.setError(2, true);
					model.userExists();
				}
		   }
		} catch (IllegalAccessException | InvocationTargetException e) {
			e.printStackTrace();
		}

		request.setAttribute("model", model);
		RequestDispatcher dispatcher = request.getRequestDispatcher(view);
		request.setAttribute("content",view);
		dispatcher.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse
	 *      response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
