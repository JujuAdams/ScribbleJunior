// Feather disable all

function ScribblejrResetPreprocesor()
{
    static _system = __ScribblejrSystem();
    
    with(_system)
    {
        if (not __preprocessorUsingDefault)
        {
            __preprocessorUsingDefault = true;
            
            __preprocessorMethod = __preprocessorDefault;
            __preprocessorName   = __preprocessorDefaultName;
            
            __preprocessorOnce = false;
        }
    }
}