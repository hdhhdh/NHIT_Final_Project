package kobus_Interface;

import java.util.ArrayList;

import dto.myCancel;
import dto.ticket;

public interface cancel_Interface {
	public ArrayList<myCancel> selectUserCancel(String user_id);
	public void addCancel(String user_id, ticket tic);
	public void countCancel();
	
}
