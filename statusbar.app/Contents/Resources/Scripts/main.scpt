FasdUAS 1.101.10   ��   ��    k             x     ��  ��    1      ��
�� 
ascr  �� 	��
�� 
minv 	 m       
 
 �    2 . 4��        x    �� ����    2  	 ��
�� 
osax��        x     �� ����    4    �� 
�� 
frmk  m       �    F o u n d a t i o n��        x     -�� ����    4   " &�� 
�� 
frmk  m   $ %   �    A p p K i t��        l     ��������  ��  ��        j   - 3�� �� 0 defaults    4   - 2��  
�� 
pcls   m   / 0 ! ! � " "  N S U s e r D e f a u l t s   # $ # l     ��������  ��  ��   $  % & % l     �� ' (��   ' h b check we are running in foreground - YOU MUST RUN AS APPLICATION to be thread safe and not crash.    ( � ) ) �   c h e c k   w e   a r e   r u n n i n g   i n   f o r e g r o u n d   -   Y O U   M U S T   R U N   A S   A P P L I C A T I O N   t o   b e   t h r e a d   s a f e   a n d   n o t   c r a s h . &  * + * l    # ,���� , Z     # - .���� - H     
 / / c     	 0 1 0 l     2���� 2 n     3 4 3 I    �������� 0 ismainthread isMainThread��  ��   4 n     5 6 5 o    ���� 0 nsthread NSThread 6 m     ��
�� misccura��  ��   1 m    ��
�� 
bool . k     7 7  8 9 8 I   �� : ;
�� .sysodisAaleR        TEXT : m     < < � = = Z T h i s   s c r i p t   m u s t   b e   r u n   f r o m   t h e   m a i n   t h r e a d . ; �� > ?
�� 
btns > J     @ @  A�� A m     B B � C C  C a n c e l��   ? �� D��
�� 
as A D m    ��
�� EAlTcriT��   9  E�� E R    ���� F
�� .ascrerr ****      � ****��   F �� G��
�� 
errn G m    ��������  ��  ��  ��  ��  ��   +  H I H l     ��������  ��  ��   I  J K J l     �� L M��   L   create the NSStatusBar    M � N N .   c r e a t e   t h e   N S S t a t u s B a r K  O P O i   4 7 Q R Q I      �������� 0 main  ��  ��   R k     4 S S  T U T r      V W V n     X Y X o    ���� "0 systemstatusbar systemStatusBar Y n     Z [ Z o    ���� 0 nsstatusbar NSStatusBar [ m     ��
�� misccura W o      ���� 0 bar   U  \ ] \ l   ��������  ��  ��   ]  ^ _ ^ r     ` a ` n    b c b I   	 �� d���� .0 statusitemwithlength_ statusItemWithLength_ d  e�� e m   	 
 f f ��      ��  ��   c o    	���� 0 bar   a o      ���� 0 
statusitem 
statusItem _  g h g l   ��������  ��  ��   h  i j i r     k l k m    ��
�� boovtrue l o      ���� 0 forever   j  m�� m V    4 n o n k    / p p  q r q r    " s t s I    �� u��
�� .sysoexecTEXT���     TEXT u m     v v � w w N / U s e r s / r n s a v i n e l l i / . l o c a l / b i n / s t a t u s b a r��   t o      ���� 0 	statusbar   r  x y x l  # #�� z {��   z $  set up the NSStatusBars title    { � | | <   s e t   u p   t h e   N S S t a t u s B a r s   t i t l e y  } ~ } n  # )  �  I   $ )�� ����� 0 	settitle_ 	setTitle_ �  ��� � l  $ % ����� � o   $ %���� 0 	statusbar  ��  ��  ��  ��   � o   # $���� 0 
statusitem 
statusItem ~  ��� � I  * /�� ���
�� .sysodelanull��� ��� nmbr � m   * +���� ��  ��   o o    ���� 0 forever  ��   P  � � � l     ��������  ��  ��   �  � � � l     �� � ���   �   call the main function    � � � � .   c a l l   t h e   m a i n   f u n c t i o n �  ��� � l  $ ) ����� � n  $ ) � � � I   % )�������� 0 main  ��  ��   �  f   $ %��  ��  ��       �� � � � � ���   � ��������
�� 
pimr�� 0 defaults  �� 0 main  
�� .aevtoappnull  �   � **** � �� ���  �   � � � � � �� 
��
�� 
vers��   � �� ���
�� 
cobj �  � �   ��
�� 
osax��   � �� ���
�� 
cobj �  � �   �� 
�� 
frmk��   � �� ���
�� 
cobj �  � �   �� 
�� 
frmk��   �  � � ���� �
�� misccura
�� 
pcls � � � �  N S U s e r D e f a u l t s � �� R���� � ����� 0 main  ��  ��   � ���������� 0 bar  �� 0 
statusitem 
statusItem�� 0 forever  �� 0 	statusbar   � 
������ f� v�~�}�|�{
�� misccura�� 0 nsstatusbar NSStatusBar�� "0 systemstatusbar systemStatusBar� .0 statusitemwithlength_ statusItemWithLength_
�~ .sysoexecTEXT���     TEXT�} 0 	settitle_ 	setTitle_�| 
�{ .sysodelanull��� ��� nmbr�� 5��,�,E�O��k+ E�OeE�O h��j E�O��k+ O�j 	[OY�� � �z ��y�x � ��w
�z .aevtoappnull  �   � **** � k     ) � �  * � �  ��v�v  �y  �x   �   � �u�t�s�r <�q B�p�o�n�m�l�k�j
�u misccura�t 0 nsthread NSThread�s 0 ismainthread isMainThread
�r 
bool
�q 
btns
�p 
as A
�o EAlTcriT�n 
�m .sysodisAaleR        TEXT
�l 
errn�k���j 0 main  �w *��,j+ �& ���kv��� 
O)��lhY hO)j+ ascr  ��ޭ