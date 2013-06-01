<h1><em>bff</em> - (4 eva and eva)</h1>

Created a 'Social Network' spoof for playing with ChicagoBoss and Erlang

<h2>What you waiting for??</h2>

<h4>Install Erlang</h4>
```
http://www.erlang.org/download.html
```

<h4>Setup ChicagoBoss</h4>
Choose a development directory to download the applications.  From that directory run:
```
git clone https://github.com/evanmiller/ChicagoBoss.git
cd ChicagoBoss
make
```

<h4>Setup ChicagoBoss Admin</h4>
Download and compile the admin application into the development directory:
```
cd ..
git clone https://github.com/evanmiller/cb_admin.git
cd cb_admin
./rebar compile
```
	
<h4>Setup <em>bff</em></h4>
Download the bff application into the development directory
```
cd ..
git clone git@github.com:nickmcdowall/bff.git
```

<h4>Start up <em>bff</em> in dev mode</h4>
```
cd bff
./init-dev.sh start
```
<h4>Get cracking..</h4>
You should now be able to hit the home page:
<a href="http://localhost:8001/">http://localhost:8001/</a>
and the admin page:
<a href="http://localhost:8001/admin">http://localhost:8001/admin</a>
