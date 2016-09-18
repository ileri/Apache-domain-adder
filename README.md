# **Apache Domain Adder**
*A short way to add a domain to your Apache2 server.*

## **Pre Install**


We are assuming that you have been installed Apache.
If you are not please lookup:
 https://www.google.com.tr/search?q=apache2+install

Turkish Installation Guide (Türkçe Kurulum Rehberi):
http://serhatcileri.com/apache-server-domain-ekle-kolay/
## **Install**


Download **domainadd.sh** to your computer. You can use:
~~~bash
wget https://raw.githubusercontent.com/celilileri/Apache-domain-adder/master/domainadd.sh
~~~

Then make it executable
~~~bash
chmod 4555 domainadd.sh
~~~

Finally copy it to one of the **PATH** s'

Youc can use:
~~~bash
sudo cp domainadd.sh /usr/bin/domainadd
sudo cp domainadd.sh /usr/bin/adddomain
~~~

***It is just that simple!***

## **Usage**

You can use as:

~~~bash
sudo adddomain
~~~

or

~~~bash
sudo domainadd
~~~


press Enter, then enter your domain address.

**Or you may prefer:**

~~~bash
sudo adddomain domainname.com
~~~

or

~~~bash
sudo domainadd domainname.com
~~~
