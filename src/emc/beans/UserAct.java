package emc.beans;

import java.io.Serializable;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

@Entity
@Table(name="user_act")
public class UserAct implements Serializable{
	
	private int logId;;
	private int userId;
	private int timeStay;
	
	@Id
	@SequenceGenerator(name="sequenceGenerator",sequenceName="logid",allocationSize=1)
	@GeneratedValue(generator="sequenceGenerator",strategy=GenerationType.SEQUENCE)
	@Column(name = "log_id")
	public int getLogId() {
		return logId;
	}
	public void setLogId(int logId) {
		this.logId = logId;
	}
	
	@Column(name = "userid")
	public int getUserId() {
		return userId;
	}
	public void setUserId(int userId) {
		this.userId = userId;
	}
	
	@Column(name = "time_stay")
	public int getTimeStay() {
		return timeStay;
	}
	public void setTimeStay(int timeStay2) {
		this.timeStay = timeStay2;
	}


	
}
