# Generated by Django 3.1.1 on 2020-12-16 13:54

from django.db import migrations


class Migration(migrations.Migration):

    dependencies = [
        ('evaluation', '0001_initial'),
    ]

    operations = [
        migrations.RenameField(
            model_name='evaluationquestions',
            old_name='quiz',
            new_name='evaluation',
        ),
    ]
