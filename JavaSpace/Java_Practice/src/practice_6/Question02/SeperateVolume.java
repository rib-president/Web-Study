package practice_6.Question02;

public class SeperateVolume implements Lendable {
	String requestNo;	// 청구번호
	String bookTitle;	// 제목
	String writer;		// 저자
	String borrower;	// 대출인
	String checkOutDate;	// 대출일
	byte state;			// 대출상태
	
	SeperateVolume(String requestNo, String bookTitle,  String writer) {
		this.requestNo = requestNo;
		this.bookTitle = bookTitle;
		this.writer = writer;
	}
	
	@Override
	public void checkOut(String borrower, String date) {
		if(state != 0) return;
		
		this.borrower = borrower;
		this.checkOutDate = date;
		this.state = 1;
		System.out.println("* " + bookTitle + " 이(가) 대출되었습니다.");
		System.out.println("대출인 : " + borrower);
		System.out.println("대출일 : " + date + "\n");
	}

	@Override
	public void checkIn() {
		this.borrower = null;
		this.checkOutDate = null;
		this.state = 0;
		System.out.println("* " + bookTitle + " 이(가) 반납되었습니다.\n");
	}
	
	@Override
	public String toString() {
		return "청구번호 : " + requestNo + ", 제목 : " + bookTitle + ", 저자 : " +
				writer + ", 대출인 : " + borrower + ", 대출일 : " + checkOutDate + 
				", 대출상태 : " + state;
	}

}
