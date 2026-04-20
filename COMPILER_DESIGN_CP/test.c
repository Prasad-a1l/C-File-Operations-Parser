fp = fopen("hero.dat", "w");
fprintf(fp, "Ironman");
fprintf(fp, "Thor");
fclose(fp);

fp = fopen("hero.dat", "r");
fscanf(fp, "%s", name);
fclose(fp);

fp = fopen("hero.dat", "wb");
fwrite(1, "Hulk");
fclose(fp);

fp = fopen("hero.dat", "rb");
fread();
fclose(fp);

fp = fopen("hero.dat", "rb");
ftell();
fseek(0);
rewind();
fclose(fp);