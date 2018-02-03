package com.liang.cpes.bean;

public class AcctCert {

	private Integer id;
	private String acctype;
	private int certid;

	public Integer getId() {
		return id;
	}

	public void setId(Integer id) {
		this.id = id;
	}

	public String getAcctype() {
		return acctype;
	}

	public void setAcctype(String acctype) {
		this.acctype = acctype;
	}

	public int getCertid() {
		return certid;
	}

	public void setCertid(int certid) {
		this.certid = certid;
	}

	@Override
	public String toString() {
		return "AcctCert [id=" + id + ", acctype=" + acctype + ", certid=" + certid + "]";
	}
	

}
