CREATE OR REPLACE PROCEDURE Recalcular_Valores_Contrato (
    p_id_contrato IN NUMBER
) AS
    v_vei NUMBER := 0;
    v_comisiones NUMBER := 0;
    v_impuestos NUMBER := 0;
    v_vtp NUMBER := 0;
BEGIN
    -- Cálculo del valor Estimado de Ingresos
    SELECT SUM(s.costo_unitario * cs.num_inquilinos)
    INTO v_vei
    FROM Contrato_Servicio cs
    JOIN Servicio s ON cs.id_servicio = s.id_servicio
    WHERE cs.id_contrato = p_id_contrato;

    -- Cálculo de comisiones por ejemplo del 10% del VEI
    v_comisiones := v_vei * 0.10;

    -- Cálculo de impuesto por ejemplo del 15% del VEI
    v_impuestos := v_vei * 0.15;

    -- Cálculo del Valor Total del Pago
    v_vtp := v_vei + v_comisiones + v_impuestos;

    -- Actualizar el contrato con los nuevos valores
    UPDATE Contrato
    SET vei = v_vei,
        comisiones = v_comisiones,
        impuestos = v_impuestos,
        vtp = v_vtp
    WHERE id_contrato = p_id_contrato;
END;
/
