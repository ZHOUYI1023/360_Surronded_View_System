function P_global = local2global(P_local, orient)
global model
switch orient
    case 'front'
        P_global.X = P_local.X;  
        P_global.Y = P_local.Y + model.wheel_length;
    case 'back'
        P_global.X = - P_local.X;
        P_global.Y = - P_local.Y;
    case 'left'
        temp = P_local.Y;
        P_global.Y = P_local.X + model.wheel_length/2;
        P_global.X = -temp - model.wheel_width/2;
    case 'right'
        temp = P_local.Y;
        P_global.Y = -P_local.X + model.wheel_length/2;
        P_global.X = temp + model.wheel_width/2;
    otherwise
        warning('Unexpected Orientation');
end
P_global.Z = P_local.Z;
end