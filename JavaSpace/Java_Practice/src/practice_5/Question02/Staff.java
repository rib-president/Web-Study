package practice_5.Question02;

public class Staff extends Employee {
	private String title;
	
	public Staff(String name, String address, String phone,
			String email, int office, double salary, String title) {
		super(name, address, phone, email, office, salary);
		this.title = title;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}
	@Override
	public String toString() {
		return super.toString() + ", title = " + title;
	}
}
