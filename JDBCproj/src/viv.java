import java.sql.Connection;
	import java.sql.DriverManager;
	import java.sql.ResultSet;
	import java.sql.SQLException;
	import java.sql.Statement;
	import java.util.logging.Level;
	import java.util.logging.Logger;
	
public class viv {
	
		public static void main(String[] args) {
			
			Connection c = null;
	        Statement stmt=null;
	        ResultSet rs=null;
	        try {
	            c = DriverManager
	                    .getConnection("jdbc:postgresql://localhost:5432/vivadb1",
	                            "postgres", "some1");
	            
	            System.out.println("Opened database successfully");
	            
	            stmt = c.createStatement();
	            
	            System.out.println("Create statement successfully");
                System.out.println();

	                        
	            
	            String sql="select category ,count(category) as doom\r\n" + 
	            		"from transactions inner join ticketbuy on transactions.ticketcode = ticketbuy.ticketcode\r\n" + 
	            		"group by category;";
	            
	            rs = stmt.executeQuery(sql);
	            System.out.println("poses pwlhseis exei h ka8e kathgoria");
	            
	            while ( rs.next() ) {
	                String  category = rs.getString(1);
	                Integer doom = rs.getInt(2);				

	                System.out.println(  category );
	                System.out.println(  doom );
	                System.out.println();

	            }
	            String sql1="select category , sum(price) as euro\r\n" + 
	            		"from transactions \r\n" + 
	            		"inner join ticketbuy on transactions.ticketcode = ticketbuy.ticketcode\r\n" + 
	            		"group by category\r\n" + 
	            		"having sum(price)=(select max(euro) as fooa\r\n" + 
	            		"				   from\r\n" + 
	            		"				   (select category , sum(price) as euro\r\n" + 
	            		"				   from transactions\r\n" + 
	            		"				   inner join ticketbuy on transactions.ticketcode = ticketbuy.ticketcode\r\n" + 
	            		"				   group by category) as t\r\n" + 
	            		"				  );";
	            
	            rs = stmt.executeQuery(sql1);
                System.out.println();
            System.out.println("poia kathgoria eisithriwn exei to megalytero tziro");
	            
	            while ( rs.next() ) {
	                String  category = rs.getString(1);
	                Integer foo = rs.getInt(2);				

	                System.out.println(  category );
	                System.out.println(  foo );
	                System.out.println();

	            }
	            
	            String sql2="select category , cast(avg(price::numeric) as decimal(10,2)) as boom\r\n" + 
	            		"from transactions \r\n" + 
	            		"inner join ticketbuy on transactions.ticketcode = ticketbuy.ticketcode\r\n" + 
	            		"inner join customers on transactions.custcode = customers.custcode\r\n" + 
	            		"where age >=16 and age<=44\r\n" + 
	            		"group by category\r\n" + 
	            		"order by cast(avg(price::numeric) as decimal(10,2)) desc;";
	            
	            rs = stmt.executeQuery(sql2);
                System.out.println();
            System.out.println("poio einai to meso kerdos ana kathgoria eisithriwn ga hlikies 16-44");
	            
	            while ( rs.next() ) {
	                String  category = rs.getString(1);
	                double boom = rs.getDouble(2);				

	                System.out.println(  category );
	                System.out.println(  boom );
	                System.out.println();
	                
	                }
	            
	            String sql3="select ticketbuy.ticketcode , count(ticketbuy.ticketcode) as maxsales\r\n" + 
	            		"from transactions \r\n" + 
	            		"inner join ticketbuy on transactions.ticketcode = ticketbuy.ticketcode\r\n" + 
	            		"group by ticketbuy.ticketcode\r\n" + 
	            		"having count(price)=(select max(maxsales) as foo\r\n" + 
	            		"				   from\r\n" + 
	            		"				   (select ticketbuy.ticketcode , count(ticketbuy.ticketcode) as maxsales\r\n" + 
	            		"				   from transactions\r\n" + 
	            		"				   inner join ticketbuy on transactions.ticketcode = ticketbuy.ticketcode\r\n" + 
	            		"				   group by ticketbuy.ticketcode) as t\r\n" + 
	            		"				  );";
	            
	            rs = stmt.executeQuery(sql3);
                System.out.println();
            System.out.println("poio 8eama ekane tis perissoteres pwlhseis");
	            
	            while ( rs.next() ) {
	                String  ticketcode = rs.getString(1);
	                Integer maxsales = rs.getInt(2);				

	                System.out.println(  ticketcode );
	                System.out.println(  maxsales );
	                System.out.println();
	            }
	                
	            String sql4="select category , customers.custcode , count(transactions.custcode) as maxcateg\r\n" + 
	            		"from transactions\r\n" + 
	            		"inner join ticketbuy on transactions.ticketcode = ticketbuy.ticketcode\r\n" + 
	            		"inner join customers on transactions.custcode = customers.custcode\r\n" + 
	            		"group by category , customers.custcode\r\n" + 
	            		"having count(transactions.custcode) = (select max(maxcateg) as foo\r\n" + 
	            		"				   from\r\n" + 
	            		"				   (select category  , customers.custcode ,  count (transactions.custcode) as maxcateg\r\n" + 
	            		"				   from transactions\r\n" + 
	            		"				   inner join ticketbuy on transactions.ticketcode = ticketbuy.ticketcode\r\n" + 
	            		"     			   inner join customers on transactions.custcode = customers.custcode\r\n" + 
	            		"				   group by category , customers.custcode) as t\r\n" + 
	            		"				  );";
	            
	            rs = stmt.executeQuery(sql4);
                System.out.println();
            System.out.println("poios einai o pelaths me tis perissoteres agores ana kathgoria");
	            
	            while ( rs.next() ) {
	            	String  category = rs.getString(1);	                		
	            	String  custcode = rs.getString(2);
	            	Integer maxcateg = rs.getInt(3);
	                System.out.println(  category );
	                System.out.println(  custcode );
	                System.out.println(  maxcateg );

	                System.out.println();
	            }
	            
	            String sql5="select compname , max(transactions.compcode) as maxcomp\r\n" + 
	            		"from transactions\r\n" + 
	            		"inner join company on transactions.compcode = company.compcode\r\n" + 
	            		"where transactions.compcode = (select max(compcode) from transactions)\r\n" + 
	            		"group by compname;";
	            
	            rs = stmt.executeQuery(sql5);
                System.out.println();
            System.out.println("poia etairia poulhse ta perissotera eisithria");
	            
	            while ( rs.next() ) {
	            	String  compname = rs.getString(1);	                		
	            	String  maxcomp = rs.getString(2);
	                System.out.println(  compname );
	                System.out.println(  maxcomp );
	                System.out.println();
	            }
	            
	            String sql6="select transactions.ticketcode\r\n" + 
	            		"from transactions \r\n" + 
	            		"inner join ticketbuy on transactions.ticketcode=ticketbuy.ticketcode\r\n" + 
	            		"where datesale>='2019-03-05'\r\n" + 
	            		"group by transactions.ticketcode;";
	            
	            rs = stmt.executeQuery(sql6);
                System.out.println();
            System.out.println("poia eishthria poulh8hkan apo tis 2019-03-05 ews kai shmera");
	            
	            while ( rs.next() ) {
	            	String  ticketcode = rs.getString(1);	                		
	                System.out.println(  ticketcode );
	                System.out.println();
	            } 
	            
	            
	        } catch (SQLException ex) {
	            Logger.getLogger(viv.class.getName()).log(Level.SEVERE, null, ex);
	        } finally {
	            try {
	                if (rs != null) {
	                    rs.close();
	                }
	                if (stmt != null) {
	                    stmt.close();
	                }
	                if (c != null) {
	                    c.close();
	                }
	            } catch (SQLException ex) {
	                Logger.getLogger(viv.class.getName()).log(Level.SEVERE, null, ex);
	            }
	        }
			
	        
		}

	}

	


