/**
* Description   - Using interface and calculate the discount for customer, employee and seller.
*
* Created by    - Nikhil Kumawat
*
* Created Date  - 29/06/2022
*
* Revision log  -  V_1.0 - Created  - Nikhil Kumawat 
*                  

**/
public virtual with sharing class DiscountOnProduct {
            public virtual interface PurchaseOrder {
                Double discount(Double price);
            }
            public class CustomerPurchaseOrder implements PurchaseOrder {
                public Double discount(Double price) {
                    return 0.9 * price;               
                }
            }
            public class EmployeePurchaseOrder implements PurchaseOrder {        
                public Double discount(Double price) {
                    return 0.7 * price;                 
                }
            }
            public class SellerPurchaseOrder implements PurchaseOrder {
                public Double discount(Double price) {
                    return 0.5 * price;               
                }
            }
            public class ProcessPurchaseOrder {
                public ProcessPurchaseOrder() {
                    PurchaseOrder order1 = new CustomerPurchaseOrder();
                    PurchaseOrder order2 = new EmployeePurchaseOrder();
                    PurchaseOrder order3 = new SellerPurchaseOrder();
        
                    processOrder(order1, ' You will get 10 % discount as a customer');
                    processOrder(order2, ' You will get 30 % discount as a employee');
                    processOrder(order3, ' You will get 50 % discount as a seller');
                }
                public void processOrder(PurchaseOrder order, String str) {
                    System.debug('Price ::: ' + order.discount(100) + str);
                }
    }
}

/*
    public virtual class Report{
        public class CustomReport extends Report{
                  // Create a list of report objects
          	Report[] Reports = new Report[5];
  // Create a custom report object
  			CustomReport a = new CustomReport();

  // Because the custom report is a sub class of the Report class,
  // you can add the custom report object a to the list of report objects
  			Reports.add(a);

  // The following is not legal:
  // CustomReport c = Reports.get(0);
  // because the compiler does not know that what you are
  // returning is a custom report. 

  // You must use cast to tell it that you know what
  // type you are returning. Instead, get the first item in the list
  // by casting it back to a custom report object
  CustomReport c = (CustomReport) Reports.get(0);
        }   
    }
*/