public with sharing class DownTrianglePattern {
    public DownTrianglePattern() {
        boolean k = true;
        for(integer i=1 ; i<=5 ; i++)
        {
            string s = ' ';
            for(integer j =1 ; j<=9 ; j++)
            {
                if(i>=2 && i<=4)
                {
                    if(j>=1+i && j<=9-i)
                    {
                        k = false;
                    }
                    else
                    {
                        k = true;
                    }
                }
                else
                {
                    k = true;
                }

                if(j>=i && j<=10-i && k)
                {
                    s = s + '*';
                }
                else
                {
                    s = s + '_';
                }
            }

            System.debug(s);
        }
    }
}