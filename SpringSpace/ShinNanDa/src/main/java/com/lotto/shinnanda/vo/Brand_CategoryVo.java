package com.lotto.shinnanda.vo;

public class Brand_CategoryVo {
	private int brand_no;
	private String brand_name;
	
	public Brand_CategoryVo() {
		super();
	}

	public Brand_CategoryVo(int brand_no, String brand_name) {
		super();
		this.brand_no = brand_no;
		this.brand_name = brand_name;
	}

	public int getBrand_no() {
		return brand_no;
	}

	public void setBrand_no(int brand_no) {
		this.brand_no = brand_no;
	}

	public String getBrand_name() {
		return brand_name;
	}

	public void setBrand_name(String brand_name) {
		this.brand_name = brand_name;
	}
}
