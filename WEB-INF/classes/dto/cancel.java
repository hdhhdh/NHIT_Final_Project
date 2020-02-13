package dto;

import java.util.Date;

public class cancel {
	private int cancel_id;
	private int bus_id;
	private int seat_num;
	private String u_id;
	private Date cancel_time;
	private int refund;
	
	public int getCancel_id() {
		return cancel_id;
	}
	public void setCancel_id(int cancel_id) {
		this.cancel_id = cancel_id;
	}
	public int getBus_id() {
		return bus_id;
	}
	public void setBus_id(int bus_id) {
		this.bus_id = bus_id;
	}
	public int getSeat_num() {
		return seat_num;
	}
	public void setSeat_num(int seat_num) {
		this.seat_num = seat_num;
	}
	public String getU_id() {
		return u_id;
	}
	public void setU_id(String u_id) {
		this.u_id = u_id;
	}
	public Date getCancel_time() {
		return cancel_time;
	}
	public void setCancel_time(Date cancel_time) {
		this.cancel_time = cancel_time;
	}
	public int getRefund() {
		return refund;
	}
	public void setRefund(int refund) {
		this.refund = refund;
	}
	
	
}
