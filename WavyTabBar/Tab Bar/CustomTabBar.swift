//
//  CustomTabBar.swift
//  WavyTabBar
//
//  Created by Shwait Kumar on 03/02/23.
//

import UIKit

class WaveView: UIView {
    var trough: CGFloat {
        didSet { setNeedsDisplay() }
    }

    var color: UIColor {
        didSet { setNeedsDisplay() }
    }

    init(trough: CGFloat, color: UIColor = .white) {
        self.trough = trough
        self.color = color

        super.init(frame: .zero)

        contentMode = .redraw
        isOpaque = false
    }

    override func draw(_ rect: CGRect) {
        guard let gc = UIGraphicsGetCurrentContext() else { return }

        let bounds = self.bounds
        let size = bounds.size
        gc.translateBy(x: bounds.origin.x, y: bounds.origin.y)

        gc.move(to: .init(x: 0, y: size.height))

        gc.saveGState(); do {
            // Transform the geometry so the bounding box of the curve
            // is (-1, 0) to (+1, +1), with the y axis going up.
            gc.translateBy(x: bounds.midX, y: trough)
//            gc.scaleBy(x: bounds.size.width * 0.5, y: -trough)
            gc.scaleBy(x: bounds.size.width * 0.8, y: -trough) // for longer wave

            // Now draw the curve.
            for x in stride(from: -1, through: 1, by: 2 / size.width) {
                let y = (cos(2.5 * .pi * x) + 1) / 2 * (1 - x * x)
                gc.addLine(to: .init(x: x, y: y))
            }
        }; gc.restoreGState()

        // The geometry is restored.
        gc.addLine(to: .init(x: size.width, y: size.height))
        gc.closePath()

        gc.setFillColor(UIColor.white.cgColor)
        gc.fillPath()
    }

    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
}
