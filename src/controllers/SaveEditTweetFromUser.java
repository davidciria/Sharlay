package controllers;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import managers.ManageTweet;

/**
 * Servlet implementation class SaveEditTweetFromUser
 */
@WebServlet("/SaveEditTweetFromUser")
public class SaveEditTweetFromUser extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public SaveEditTweetFromUser() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		String tweetText = request.getParameter("tweetText");
		System.out.println(tweetText);
		String tweetidStr = request.getParameter("tweetid");
		Integer tweetid = Integer.parseInt(tweetidStr);
		if(tweetText != "") {		
			ManageTweet tweetManager = new ManageTweet();
			tweetManager.editTweet(tweetid, tweetText);
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
