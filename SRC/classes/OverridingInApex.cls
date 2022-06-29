public virtual class OverridingInApex {
    public virtual class Parent {
        private Integer prvt;
        protected Integer ptcd;
        public Integer pub;
        public virtual void getValues(){
            System.debug('Prvt man' +prvt);
            System.debug('ptcd men' +ptcd);
            System.debug('pub men' +pub);
        }        
    }
    public virtual class Child extends Parent{
        public Integer prvt;
        public override void getvalues(){
            System.debug('prvt ch men' +prvt);
        }
    }
    public class Test{
        public void main(){
            Parent p1 = new Parent();
            p1.getValues();
            Child c1 = new Child();
            c1.getValues();
        }
    }
}