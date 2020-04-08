package member;

public class eeeee {
	public void passwordEncode() {
		String password = "another";
		String s ="";
		String[] pass = null;
		for(int i=0; i<password.length();i++) {
			int passch = password.charAt(i);
			
			passch = passch*(i+1);
			s += String.format("%02X%n", passch);

		}
		System.out.println("zzz : "+s);
		String rivers = "";
		for(int i=s.length()-1;i>0;i--) {
			rivers += s.charAt(i);
		}
		
		System.out.println("dddd : "+rivers);
	}
	public static void main(String[] args) {
		// TODO Auto-generated method stub
		eeeee e = new eeeee();
		e.passwordEncode();
	}

}
