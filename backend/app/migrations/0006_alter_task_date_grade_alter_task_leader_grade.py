# Generated by Django 4.0.5 on 2022-12-08 10:11

from django.db import migrations, models


class Migration(migrations.Migration):

    dependencies = [
        ('app', '0005_alter_task_date_grade_alter_task_leader_grade'),
    ]

    operations = [
        migrations.AlterField(
            model_name='task',
            name='date_grade',
            field=models.IntegerField(default=0),
        ),
        migrations.AlterField(
            model_name='task',
            name='leader_grade',
            field=models.IntegerField(default=0),
        ),
    ]
