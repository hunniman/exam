package com.demo.user;

public enum Position {
	
	admin(1),normal(0);
	
	private int _type;

	private Position(int type) {
		this._type = type;
	}

	public int getPosition() {
		return this._type;
	}
}
