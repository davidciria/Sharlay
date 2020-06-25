package controllers;

import java.io.IOException;
import java.util.Collections;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;

import managers.ManageTweet;
import models.Tweet;
import models.dTmodel;

/**
 * Servlet implementation class GetAllTweetsFollowing
 */
@WebServlet("/GetAllTweetsFollowing")
public class GetAllTweetsFollowing extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public GetAllTweetsFollowing() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		dTmodel dt = new dTmodel();
		List<Tweet> tweets = Collections.emptyList();
		
		try {
			BeanUtils.populate(dt, request.getParameterMap());
			ManageTweet tweetManager = new ManageTweet();
			tweets = tweetManager.getAllTweetsFollowing(dt.getUid(), dt.getStart(), dt.getEnd());
			tweetManager.finalize();
		
		} catch (Exception e) {
			e.printStackTrace();
		}

		request.setAttribute("tweets",tweets);
		RequestDispatcher dispatcher = request.getRequestDispatcher("/viewAllTweets.jsp"); 
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
