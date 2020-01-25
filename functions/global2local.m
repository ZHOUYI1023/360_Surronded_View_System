function p_local = global2local(p_global, orient)
global model
switch orient
    case 'front'
        R = [1,0; 0,1];
        t = [0; -model.wheel_length];
    case 'back'
        R = [-1,0; 0,-1];
        t = [0; 0];
    case 'left'
        R = [0,1; -1,0];
        t = [-model.wheel_length/2; -model.wheel_width/2];
    case 'right'
        R = [0,-1; 1,0];
        t = [model.wheel_length/2; -model.wheel_width/2];
    otherwise
        warning('Unexpected Orientation');
end
p_local = R * p_global' + t;
end