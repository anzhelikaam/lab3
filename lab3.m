clc
clear

% Ініціалізація шаблонів цифр (матриці 5x5)
D0 = [-1  1  1  1 -1;
       1 -1 -1 -1  1;
       1 -1 -1 -1  1;
       1 -1 -1 -1  1;
      -1  1  1  1 -1];

D1 = [-1 -1  1 -1 -1;
      -1  1  1 -1 -1;
      -1 -1  1 -1 -1;
      -1 -1  1 -1 -1;
      -1  1  1  1 -1];

D2 = [-1  1  1  1 -1;
       1 -1 -1 -1  1;
      -1 -1 -1  1 -1;
      -1 -1  1 -1 -1;
       1  1  1  1  1];

D3 = [-1  1  1  1 -1;
      -1 -1 -1 -1  1;
      -1 -1  1  1 -1;
      -1 -1 -1 -1  1;
      -1  1  1  1 -1];

D4 = [-1 -1 -1  1 -1;
      -1 -1  1  1 -1;
      -1  1 -1  1 -1;
       1  1  1  1  1;
      -1 -1 -1  1 -1];

D5 = [ 1  1  1  1  1;
       1 -1 -1 -1 -1;
       1  1  1  1 -1;
      -1 -1 -1 -1  1;
       1  1  1  1 -1];

D6 = [-1  1  1  1 -1;
       1 -1 -1 -1 -1;
       1  1  1  1 -1;
       1 -1 -1 -1  1;
      -1  1  1  1 -1];

D7 = [ 1  1  1  1  1;
      -1 -1 -1  1 -1;
      -1 -1  1 -1 -1;
      -1  1 -1 -1 -1;
      -1  1 -1 -1 -1];

D8 = [-1  1  1  1 -1;
       1 -1 -1 -1  1;
      -1  1  1  1 -1;
       1 -1 -1 -1  1;
      -1  1  1  1 -1];

D9 = [-1  1  1  1 -1;
       1 -1 -1 -1  1;
      -1  1  1  1  1;
      -1 -1 -1 -1  1;
      -1  1  1  1 -1];

% Відображення шаблонів цифр
figure(1);
subplot(2,5,1); imagesc(D0); title('Шаблон 0');
subplot(2,5,2); imagesc(D1); title('Шаблон 1');
subplot(2,5,3); imagesc(D2); title('Шаблон 2');
subplot(2,5,4); imagesc(D3); title('Шаблон 3');
subplot(2,5,5); imagesc(D4); title('Шаблон 4');
subplot(2,5,6); imagesc(D5); title('Шаблон 5');
subplot(2,5,7); imagesc(D6); title('Шаблон 6');
subplot(2,5,8); imagesc(D7); title('Шаблон 7');
subplot(2,5,9); imagesc(D8); title('Шаблон 8');
subplot(2,5,10); imagesc(D9); title('Шаблон 9');

% Ініціалізація матриць для розрахунків
V = [D0(:) D1(:) D2(:) D3(:) D4(:) D5(:) D6(:) D7(:) D8(:) D9(:)];
alpha = 0.8;
iter = 10;

% Розрахунок вагової матриці
W = V * V';
W = W - diag(diag(W));

% Створення випадкової вхідної матриці
x = sign(2*rand(25,1)-1);
x = reshape(x,5,5);

% Ітеративне оновлення матриці
figure(2);
for k = 1:iter
    x = reshape(x,5,5);
    subplot(1,2,1);
    imagesc(x);
    title(['Ітерація ', num2str(k)]);
    x = reshape(x,25,1);

    xtemp = alpha*W*x;
    for j = 1:length(xtemp)
        if xtemp(j) > 0
            x(j) = 1;
        else
            x(j) = -1;
        end
    end
end

% Додаткова функція для порівняння з шаблонами
figure(3);
subplot(1,2,1);
imagesc(reshape(x,5,5));
title('Результат розпізнавання');

% Обчислення схожості з шаблонами
similarity = zeros(1,10);
for i = 1:10
    similarity(i) = sum(x .* V(:,i));
end

% Знаходження найбільш схожого шаблону
[~, max_idx] = max(similarity);
detected_digit = max_idx - 1;

subplot(1,2,2);
switch max_idx
    case 1, imagesc(D0);
    case 2, imagesc(D1);
    case 3, imagesc(D2);
    case 4, imagesc(D3);
    case 5, imagesc(D4);
    case 6, imagesc(D5);
    case 7, imagesc(D6);
    case 8, imagesc(D7);
    case 9, imagesc(D8);
    case 10, imagesc(D9);
end
title(['Розпізнана цифра: ', num2str(detected_digit)]);

% Виведення значення схожості для кожної цифри
disp('Схожість з шаблонами:');
for i = 1:10
    disp(['Цифра ', num2str(i-1), ': ', num2str(similarity(i))]);
end
