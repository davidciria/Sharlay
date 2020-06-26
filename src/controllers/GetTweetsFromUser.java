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

import managers.ManageTweet;
import models.Tweet;
import models.dTmodel;

/**
 * Servlet implementation class GetTweetsFromUser
 * 
 * Servlet per obtenir tweets dun usuari.
 * 
 */
@WebServlet("/GetTweetsFromUser")
public class GetTweetsFromUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetTweetsFromUser() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		dTmodel dt = new dTmodel();
		List<Tweet> tweets = Collections.emptyList();
		
		HttpSession session = request.getSession(false);
		ManageTweet tweetManager = new ManageTweet();
		
		String cview = "";
		
		if(session != null) {
			//Usuari loggejat.
			int uid = (int)session.getAttribute("uid");
			cview = "/viewTweetsFromUser.jsp";
			try {
				BeanUtils.populate(dt, request.getParameterMap());
				try {
					tweets = tweetManager.getUserTweets(dt.getUid(),dt.getStart(),dt.getEnd(), uid);
				} catch (Exception e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			
			} catch (IllegalAccessException | InvocationTargetException e) {
				e.printStackTrace();
			}
			
			request.setAttribute("tweets",tweets);
		}
		else {
			//Usuari anonymouse.
			cview = "/viewTweetsFromUserAnonymouse.jsp";
			try {
				BeanUtils.populate(dt, request.getParameterMap());
			} catch (IllegalAccessException | InvocationTargetException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			try {
				tweets = tweetManager.getUserTweetsAnonymouse(dt.getUid(),dt.getStart(),dt.getEnd());
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			
			request.setAttribute("tweets",tweets);
		}
		
		tweetManager.finalize();
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(cview); 
		dispatcher.forward(request,response);
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}