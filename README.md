Description
===========
Base provider Test cookbook to simulate building tomcat.



Server settings
==============
<table>
<tr>
  <th>Value
  <th>Type
  <th>Default
  <th>Description
</tr>
<tr>
  <td>serverBase
  <td>String
  <td>/data/servers
  <td>Base path to install to
</tr>
<tr>
  <td>enable
  <td>True/False
  <td>true
  <td>Enable service for boot time start
</tr>
<tr>
  <td>start
  <td>True/False
  <td>true
  <td>Start service if not running
</tr>
<tr>
  <td>fileChangeRestart
  <td>True/False
  <td>true
  <td>When set to true, if any major config file is changed, the service will be restarted.
</tr>
</table>
