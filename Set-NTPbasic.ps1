
# Set Time servers in Registry
# time.windows.com reageert niet lekker vanaf waternet


$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\DateTime\Servers"


New-ItemProperty -Path $registryPath -Name "1" -Value "0.nl.pool.ntp.org" -PropertyType String -Force | Out-Null
New-ItemProperty -Path $registryPath -Name "2" -Value "1.nl.pool.ntp.org" -PropertyType String -Force | Out-Null    
New-ItemProperty -Path $registryPath -Name "3" -Value "2.nl.pool.ntp.org" -PropertyType String -Force | Out-Null
New-ItemProperty -Path $registryPath -Name "4" -Value "3.nl.pool.ntp.org" -PropertyType String -Force | Out-Null
New-ItemProperty -Path $registryPath -Name "5" -Value "time.windows.com" -PropertyType String -Force | Out-Null
New-ItemProperty -Path $registryPath -Name "6" -Value "time.nist.gov" -PropertyType String -Force | Out-Null


$TimeServers= "0.nl.pool.ntp.org","1.nl.pool.ntp.org","2.nl.pool.ntp.org","3.nl.pool.ntp.org"

w32tm /configure /manualpeerlist:$TimeServers /syncfromflags:manual /update
    if ((Get-Service -name W32Time).status -eq "Running" -eq $true){
			net stop w32time }
    
			net start w32time