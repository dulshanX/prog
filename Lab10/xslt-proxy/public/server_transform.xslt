<?xml version="1.0" encoding="UTF-8"?>

<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

  <!--xsl:template говорит о том, что тут будет замена. match показывает, к какой части документа это применимо-->
  <xsl:template match="/">
    <!--Внутри шаблона пишем наше преобразование-->

    <table class="table">

      <thead>

        <tr>

          <th>#</th>
          <th>Числа</th>
          <th>Квадраты чисел</th>

        </tr>

      </thead>

      <!--Цикл-->
      <xsl:for-each select="objects/object">

        <!--Создание переменной-->
        <xsl:variable name="counter" select="position()"/>

        <tbody>

          <tr>

            <td>
              <!--Извлекаем значение из переменной (обратите внимание на $)-->
              <xsl:value-of select="$counter"></xsl:value-of>
            </td>
            <td>
              <!--Извлекаем значение из XML-тега-->
              <xsl:value-of select="elem"></xsl:value-of>
            </td>
            <td>
              <xsl:value-of select="sqr"></xsl:value-of>
            </td>

          </tr>

        </tbody>

      </xsl:for-each>

    </table>

  </xsl:template>

</xsl:stylesheet>