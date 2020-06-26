package controllers;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;

import managers.ManageTweet;
import models.Tweet;
/**
 * Servlet implementation class DelTweetFromUser
 * 
 * Eliminar un tweet.
 * 
 */
@WebServlet("/DelTweetFromUser")
public class DelTweetFromUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public DelTweetFromUser() {
        super();
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		Tweet tweet = new Tweet();
		ManageTweet tweetManager = new ManageTweet();
		
		try {
			BeanUtils.populate(tweet, request.getParameterMap());
			//Eliminem el tweet.
			tweetManager.deleteTweet(tweet.getTweetid());
		} catch (Throwable e) {
			e.printStackTrace();
		}
		
		tweetManager.finalize();
		
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
