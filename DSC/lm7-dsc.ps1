Configuration RowynBaseline
{
    Node localhost
    {
        WindowsFeature TelnetClient
        {
            Name   = "Telnet-Client"
            Ensure = "Present"
        }

        Service WindowsTimeService
        {
            Name  = "W32Time"
            State = "Running"
        }
    }
}