import os
import sys
import numpy as np
import cv2
# TODO: Refactor into Functions
PATH = 'images\calib\\'
# PATH = input()
camera_matrix_front = np.float32([
    [343.649498,0,639.880327],
    [0,345.680413,343.864883],
              [0,0,1]])
dist_coeffs_front = np.array([0.085302, 0.002506, -0.000136, -0.001253])

new_camera_matrix_front = np.copy(camera_matrix_front)
new_camera_matrix_front[:2, :2] *= 0.5
try:
    img_front = cv2.imread(PATH+'front.bmp')
    img_front_undist = cv2.fisheye.undistortImage(img_front, camera_matrix_front, D=dist_coeffs_front, Knew=new_camera_matrix_front)
    cv2.imwrite(PATH+'front_undistort.bmp', img_front_undist)
except:
    pass

camera_matrix_left = np.float32([
    [344.225530,0,649.401895],
    [0,344.583468,353.879431],
              [0,0,1]])
dist_coeffs_left = np.array([0.079273, 0.007954,  -0.002051,0.001192])
new_camera_matrix_left = np.copy(camera_matrix_left)
new_camera_matrix_left[:2, :2] *= 0.5
try:
    img_left= cv2.imread(PATH+'left.bmp')
    img_left_undist = cv2.fisheye.undistortImage(img_left, camera_matrix_left, D=dist_coeffs_left, Knew=new_camera_matrix_left)
    cv2.imwrite(PATH+'left_undistort.bmp', img_left_undist)
except:
    pass

camera_matrix_right = np.float32([
    [344.023616,0,637.7890185],
    [0,344.404638,337.540235],
              [0,0,1]])
dist_coeffs_right = np.array([ 0.076698, 0.017238, -0.009614,0.000718])
new_camera_matrix_right = np.copy(camera_matrix_right)
new_camera_matrix_right[:2, :2] *= 0.5
try:
    img_right= cv2.imread(PATH+'right.bmp')
    img_right_undist = cv2.fisheye.undistortImage(img_right, camera_matrix_right, D=dist_coeffs_right, Knew=new_camera_matrix_right)
    cv2.imwrite(PATH+'right_undistort.bmp', img_right_undist)
except:
    pass

camera_matrix_rear = np.float32([
    [340.248416,0,638.833628],
    [0,340.814917,355.307842],
              [0,0,1]])
dist_coeffs_rear = np.array([ 0.092730,-0.004919,0.003793,-0.001921])
rvec_rear = np.array([-44.447182, -1.735699,-1.215525])
tvec_rear = np.array([50.034134, -1032.272461, -766.601929])
new_camera_matrix_rear = np.copy(camera_matrix_rear)
new_camera_matrix_rear[:2, :2] *= 0.5
try:
    img_rear= cv2.imread(PATH+'back.bmp')
    img_rear_undist = cv2.fisheye.undistortImage(img_rear, camera_matrix_rear, D=dist_coeffs_rear, Knew=new_camera_matrix_rear)
    cv2.imwrite(PATH+'back_undistort.bmp', img_rear_undist)
except:
    pass