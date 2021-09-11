#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#define N 1000

typedef struct student {
	char name[10];
	int score[4];
}student;

int main()
{
	char in_name[10];
	student stu[N];
	 

	strcpy(stu[0].name, "ZhangSan");
	strcpy(stu[1].name, "LiSi");
	
	int i;
	for (i = 2; i < 999; i++)            //给中间的997个暂时赋名
	{
		strcpy(stu[i].name, "TempValue");
	}

	strcpy(stu[999].name, "YangAo");

	stu[0].score[0] = 100;
	stu[0].score[1] = 85;
	stu[0].score[2] = 80;
	stu[0].score[3] = 0;

	stu[1].score[0] = 80;
	stu[1].score[1] = 100;
	stu[1].score[2] = 70;
	stu[1].score[3] = 0;

	for (i = 2; i < 999; i++)            //给中间的997个暂时赋值
	{
		stu[i].score[0] = 80;
		stu[i].score[1] = 90;
		stu[i].score[2] = 95;
		stu[i].score[3] = 0;
	}

	stu[999].score[0] = 100;
	stu[999].score[1] = 100;
	stu[999].score[2] = 100;
	stu[999].score[3] = 0;

	for (i = 0; i < 1000; i++)            //求平均值并将其放入每个学生的score[3]位置
	{
		stu[i].score[3] = (stu[i].score[0] * 4 + stu[i].score[1] * 2 + stu[i].score[2]) / 7;
	}

again: 
	printf("%s", MES1);
	scanf("%s", in_name);
	getchar();
	int j,flag,POIN;
	j = strlen(in_name);
	if (j == 0)
		goto again;
	else if (j == 1)
	{
		if (in_name[0] == 'q')
			return 0;
	}
	else
	{
		for (i = 0; i < 1000; i++)
		{
			flag = strcmp(in_name, stu[i].name);
			if (flag == 0)
				break;
		}
		if (flag != 0)
		{
			printf("%s", MES2);
			goto again;
		}
		else
		{
			POIN = i;
		}

		if (stu[i].score[3] >= 90)
			printf("A\n");
		else if (stu[i].score[3] >= 80)
			printf("B\n");
		else if (stu[i].score[3] >= 70)
			printf("C\n");
		else if (stu[i].score[3] >= 60)
			printf("D\n");
		else
			printf("F\n");

	}


	return 0;
}
