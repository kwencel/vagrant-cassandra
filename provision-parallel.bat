@echo off

:: start boxes sequentially to avoid vbox explosions
vagrant up --no-provision

:: but run provision tasks in parallel
echo Starting provisioning in the separate minimized console windows. They will close themselves if provisioning was successful.
if not exist logs\NUL mkdir logs
FOR %%A IN (node1 node2 node3) DO start /min cmd /k "(vagrant provision %%A > logs/%%A.log 2>&1 && exit) || echo Error Occurred: check logs/%%A.log"
