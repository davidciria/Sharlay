package utils;

import java.util.Comparator;

import models.Tweet;

public class SortTweetsByTime implements Comparator<Tweet> {
	@Override
	public int compare(Tweet arg0, Tweet arg1) {
		// TODO Auto-generated method stub
		return -arg0.getCreatedAt().compareTo(arg1.getCreatedAt());
		
	}
}
