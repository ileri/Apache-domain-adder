# Apache-domain-adder
A short way to add a domain to your Apache2 server.

## **Install**
Download **domainadd.sh** to your computer. You can use:
~~~bash
wget https://github.com/celilileri/Apache-domain-adder/blob/master/domainadd.sh
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
