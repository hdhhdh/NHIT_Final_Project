package kobus_Interface;

public interface user_Interface {
	public boolean userLogin(String id, String pw);
	public boolean userSignUp(String id, String pw, String name, int age, int gender);
	public void userPayment(String user_id, int pay);
	public void userRefund(String user_id, int re);
}
