#!/usr/bin/python
# -*- coding: utf-8 -*-
import sys
import numpy as np
import pygame
from pygame.locals import *
from OpenGL.GL import *
from OpenGL.GLU import *
from PIL import Image
sys.path.append('output')
from bowl import BowlfrontVer, BowlrightVer, BowlbackVer, BowlleftVer
from bowl import BowlfrontText, BowlrightText, BowlbackText, BowlleftText

bowlVer = [BowlfrontVer, BowlrightVer, BowlbackVer, BowlleftVer]
bowlTex = [BowlfrontText, BowlrightText, BowlbackText, BowlleftText]

imgFiles = ['images/front_undistort.bmp','images/right_undistort.bmp','images/back_undistort.bmp','images/left_undistort.bmp']

# draw the model
def Bowl(bowlVer, bowlTex, imgFiles):
	# load textures
	for i in range(4):
		img = Image.open(imgFiles[i])
		ver = bowlVer[i]
		tex = bowlTex[i]
		width, height = img.size
		img = img.tobytes('raw','RGBX',0,-1)
		glGenTextures(2)
		glBindTexture(GL_TEXTURE_2D, i)
		glTexImage2D(GL_TEXTURE_2D, 0, 4, width, height, 0, GL_RGBA, GL_UNSIGNED_BYTE,img)
		glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP)
		glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP)
		glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT)
		glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT)
		glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST)
		glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST)
		glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_DECAL)
		# bind textures
		glBindTexture(GL_TEXTURE_2D, i)
		linenum = ver.shape[0]
		for m in range(linenum):
			glBegin(GL_TRIANGLE_STRIP)
			for n in range(4):
				glTexCoord2fv(tex[m][n])
				glVertex3fv(ver[m][n]) 			
			glEnd()	


def InitGL(width, height):
	pygame.display.set_mode([width, height], DOUBLEBUF|OPENGL)
	glEnable(GL_TEXTURE_2D)
	glClearColor(1.0, 1.0, 1.0, 0.0)
	glClearDepth(1.0)
	glDepthFunc(GL_LESS)
	glShadeModel(GL_SMOOTH)
	glEnable(GL_CULL_FACE)
	glCullFace(GL_BACK)
	glEnable(GL_POINT_SMOOTH)
	glEnable(GL_LINE_SMOOTH)
	glEnable(GL_POLYGON_SMOOTH)
	glMatrixMode(GL_PROJECTION)
	glHint(GL_POINT_SMOOTH_HINT,GL_NICEST)
	glHint(GL_LINE_SMOOTH_HINT,GL_NICEST)
	glHint(GL_POLYGON_SMOOTH_HINT,GL_NICEST)
	glLoadIdentity()
	gluPerspective(75.0, float(width)/float(height), 0.1, 50.0)
	glMatrixMode(GL_MODELVIEW)
	glTranslate(0.0, 0.0, 0.0)
	glRotatef(0.0, 0.0, 0.0, 0.0)


# main
def main():
	# initilization
	pygame.init()
	display = (1280,720)
	InitGL(display[0], display[1])
	while True:
		for event in pygame.event.get():
			if event.type == pygame.QUIT:
				pygame.quit()
				quit()
			if event.type == pygame.KEYDOWN:
				if event.key == pygame.K_LEFT:
					glTranslate(-1,0,0)
				if event.key == pygame.K_RIGHT:
					glTranslate(1,0,0)
				if event.key == pygame.K_UP:
					glTranslate(0,0,1)
					# glRotatef(10,0,1,0)
				if event.key == pygame.K_DOWN:
					glTranslate(0,0,-1)
					# glRotatef(-10,0,1,0)
				if event.key == pygame.K_w:
					glRotatef(10,1,0,0)
				if event.key == pygame.K_s:
					glRotatef(-10,1,0,0)
				if event.key == pygame.K_a:
					glRotatef(-10,0,0,1)
				if event.key == pygame.K_d:
					glRotatef(10,0,0,1)

			if event.type == pygame.MOUSEBUTTONDOWN:
				if event.button == 4:
					glTranslate(0,1,0)
				if event.button == 5:
					glTranslate(0,-1,0)
		glClear(GL_COLOR_BUFFER_BIT|GL_DEPTH_BUFFER_BIT)
		glRotatef(1, 0, 1, 0) #automatic rotate
		glEnable(GL_TEXTURE_2D)
		Bowl(bowlVer, bowlTex, imgFiles)
		pygame.display.flip()
		pygame.time.wait(10)


# call the main function
if __name__ == "__main__":
	main()